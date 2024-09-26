lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 53.13069069069069 --fixed-mass2 84.73125125125125 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010825477.5014582 \
--gps-end-time 1010832677.5014582 \
--d-distr volume \
--min-distance 2534.0038605412333e3 --max-distance 2534.0238605412337e3 \
--l-distr fixed --longitude -9.7471923828125 --latitude -18.98105812072754 --i-distr uniform \
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
