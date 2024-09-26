lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 39.85173173173173 --fixed-mass2 67.50222222222223 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026013777.6452152 \
--gps-end-time 1026020977.6452152 \
--d-distr volume \
--min-distance 3636.4432549574103e3 --max-distance 3636.4632549574108e3 \
--l-distr fixed --longitude -173.23294067382812 --latitude 39.89665985107422 --i-distr uniform \
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
