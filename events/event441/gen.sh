lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 24.387627627627626 --fixed-mass2 58.17333333333334 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021217137.3560095 \
--gps-end-time 1021224337.3560095 \
--d-distr volume \
--min-distance 2316.2371175953754e3 --max-distance 2316.257117595376e3 \
--l-distr fixed --longitude -93.73300170898438 --latitude 82.06120300292969 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
